global class Batch_DFGAssignPermissions implements Database.Batchable<sObject> {
    
    public String query {get;set;}

    //по строке определяем операцию, add - добавление пользователей, del - удаление
    public String command {get;set;}
    public Map<String,String> params {get;set;}
    
    global Batch_DFGAssignPermissions() {}
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        system.debug('in batch start');
        if (Test.IsRunningTest()) query += ' limit 2';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<sObject> scope) 
    { 

        system.debug('in Batch_DFGAssignPermissions execute');

        if (scope != null){
            system.debug('scope.size = ' + scope.size());
        }
        
        
        TokenizationSettings__c tokenSettings = TokenizationSettings__c.getValues('Param');
        system.debug('params : ' + params + ' ; tokenSettings: ' + tokenSettings);
        if (params == null || params.get('UserField__c') == null || tokenSettings == null || tokenSettings.SignLocalization__c == null) return;

        system.debug('running process');
        //достаём имена Permission Set'ов
        String setUserName = params.get('SimpleAccess__c');
        String setAdvancedUserName = params.get('TokenizationAccess__c');

        String countryField = params.get('UserField__c').deleteWhitespace();
        String countryLabel = tokenSettings.SignLocalization__c.toLowerCase();
 
        List<PermissionSet> permissionsL = [SELECT ID, Name From PermissionSet WHERE Name =: setUserName or Name =: setAdvancedUserName];
        system.debug('permissionsL = ' + permissionsL);

        Set<String> psaIDS = new Set<String>();

        //сет с пользователями, уже имеющими права доступа
        Set<String> usersWithAccess = new Set<String>();

        //получаем сами permission Set'ы
        Map <String, PermissionSet> permissionMap = new Map<String,PermissionSet>();


        PermissionSet setUser;
        PermissionSet setAdvancedUser; 

        for (PermissionSet ps: permissionsL){ 
            psaIDS.add(ps.Id); 
            if (ps.Name == setUserName) { 
                permissionMap.put('user', ps); 
            }
            if (ps.Name == setAdvancedUserName) {
                permissionMap.put('advancedUser', ps); 
            } 
        }   


        List<PermissionSetAssignment> psaList =  [SELECT AssigneeId FROM PermissionSetAssignment WHERE PermissionSetId IN: psaIDS];

        if (psaList != null && psaList.size()>0)
        {
            for (PermissionSetAssignment psa : psaList) 
            { 
                usersWithAccess.add(psa.AssigneeId); 
            }
        }
        

        system.debug('countryLabel = ' + countryLabel); 

        if (command == 'add')
        {
                
                list <PermissionSetAssignment> userPSAssignments = new list <PermissionSetAssignment>();
                list <PermissionSetAssignment> advancedPSAssignments = new list <PermissionSetAssignment>();

                for( SObject s : scope)
                {

                    system.debug('s.get(countryField) = ' + s.get(countryField) );

                    User u = (User)s;
                    system.debug('u.name = ' + u.name);

                    if (usersWithAccess.contains(u.Id)) continue;
                    //если введено название Permission set для пользователя БЕЗ локализации
                        if (permissionMap.get('user') != null){ 


                            //и если пользователь без метки
                            if (s.get(countryField) == null || (s.get(countryField) != null && String.valueOf(s.get(countryField)).toLowerCase() != countryLabel)){
                                userPSAssignments.add( new PermissionSetAssignment(AssigneeId = u.id,PermissionSetId = permissionMap.get('user').id ) );
                                system.debug('permissions for user added');
                            }

                        }

                        //если введено название Permission set для пользователя С локализацией
                        if (permissionMap.get('advancedUser') != null){ 
                            //если пользователь с меткой
                            if (s.get(countryField) != null && String.valueOf(s.get(countryField)).toLowerCase()  == countryLabel){
                                advancedPSAssignments.add( new PermissionSetAssignment(AssigneeId = u.id,PermissionSetId = permissionMap.get('advancedUser').id ) );
                                system.debug('permissions for advanced user added');
                            }

                        } 

                }


                if (userPSAssignments.size() > 0) 
                    if (!Test.IsRunningTest()) insert userPSAssignments;
                                                                    
                
                if (advancedPSAssignments.size() > 0) 
                    if (!Test.IsRunningTest()) insert advancedPSAssignments;

        } 
        else if (command == 'del')
        {
            system.debug('command del, psaList = ' + psaList);
             if (psaList != null && psaList.size()>0) 
                DELETE psaList;
        }
        
    }
    
    global void finish(Database.BatchableContext BC) {
        
    }
    
}