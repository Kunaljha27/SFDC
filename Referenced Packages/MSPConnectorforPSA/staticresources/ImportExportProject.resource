 		$(document).ready(function() {
            myApp.hidePleaseWait(); 
        });

        var inProgress=false;
        function disableButton(){
            document.getElementById("pg:frm:cmdExport").disabled=true;
             myApp.showPleaseWait();
        }

        function check(obj) { 
        if(inProgress==false)
            {
            var path = obj.value;
            var ext = path.substring(path.lastIndexOf('.') + 1);
            $('#msgsDiv').remove(); 
            
            
            if(ext !="xml")
            {
                obj.value = null;
              
                $('#divAlert').append('<div id="msgsDiv" class="alert alert-warning"><p class="warning">Please select only xml file.</p></div>');
                        
                return false;
            }
            }
            
        }
        function stop(obj) { 
            if(inProgress==true)
                {
                
                $(obj).attr('disabled', 'disabled');
                }
        
        }
        var myApp;
            myApp = myApp || (function () {
             //   var pleaseWaitDiv = $('<div  id="pleaseWaitDialog" data-backdrop="static" data-keyboard="false"><div class="modal-header"><h1>Processing...</h1></div><div class="modal-body"><div class="progress progress-striped active"><div class="bar" style="width: 100%;"></div></div></div></div>');
             //   $("#divAlert").append(pleaseWaitDiv);
                return {
                    showPleaseWait: function() {
                        $("#pleaseWaitDialog").show();
                    },
                    hidePleaseWait: function () {
                        $("#pleaseWaitDialog").hide();
                    },
            
                };
            })();
        
        

        function closeWindow()
            {
                //Refresh parent when pop up is closed
                window.opener.location.href="/{!JSENCODE($CurrentPage.parameters.Id)}";
                
                //Taking care of all browsers
                var Browser = navigator.appName;
                var indexB = Browser.indexOf('Explorer');

                if (indexB > 0) {
                    var indexV = navigator.userAgent.indexOf('MSIE') + 5;
                    var Version = navigator.userAgent.substring(indexV, indexV + 1);
                
                    if (Version >= 7) {
                        window.open('', '_self', '');
                        window.close();
                    }
                    else if (Version == 6) {
                        window.opener = null;
                        window.close();
                    }
                    else {
                        window.opener = '';
                        window.close();
                    }
                
                 }
                else {
                    window.close();
                 }
            }  