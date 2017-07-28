global with sharing class RX_IOMetadataWrapper {
	public String Custom_Object_Name { get; set; }
	public String External_Id { get; set; }
	public Boolean NeedUpsert { get; set; }
	public Decimal Sequence { get; set; }
	public String Upsert_Field { get; set; }
	public String MasterLabel { get; set; }
	public String DeveloperName { get; set; }
	public String NamespacePrefix { get; set; }
	public String Where_Clause {get; set;}
	public String Product_Where_Clause {get; set;}
	global RX_IOMetadataWrapper(String MasterLabel, String DeveloperName) {
		this.MasterLabel = MasterLabel;
		this.DeveloperName = DeveloperName;
	}
}