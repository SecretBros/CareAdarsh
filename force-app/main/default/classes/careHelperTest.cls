@isTest
private class careHelperTest {

    @isTest
    static void testUpdateTotalOpportunity() {
        TriggerConfig__c triggerConfig = new TriggerConfig__c();
        triggerConfig.Name='Opportunity'; 
        triggerConfig.ApexHandler__c='careHandler'; 
        triggerConfig.IsActive__c=true;
        triggerConfig.SkipForUsers__c=null;
        insert triggerConfig;
        // Create a test Care__c record
        Care__c testCare = new Care__c(Name = 'Test Care');
        insert testCare;

        // Create a list to hold the test Opportunities
        List<Opportunity> opportunities = new List<Opportunity>();

        // Create test Opportunities related to the Care__c record
        for (Integer i = 1; i <= 500; i++) {
            opportunities.add(new Opportunity(
                Name = 'Test Opportunity ' + i,
                StageName = (i == 3) ? 'Closed Lost' : 'Closed Won',
                Amount = i*100 ,
                CloseDate=System.today(),
                OPPCARE__c = testCare.Id
            ));
        }
        insert opportunities;

        for (Opportunity opp : opportunities) {
            opp.Amount = 20;
        }
        update opportunities;
 
       Care__c  testCare1 = [SELECT Id, TotalOpportunitySUM__c FROM Care__c WHERE Id = :testCare.Id];
        // Verify the TotalOpportunitySUM__c field
        System.assertEquals(10000, testCare1.TotalOpportunitySUM__c);
    }


    @isTest
    static void testUpdateTotalOpportunityAvg() {
        TriggerConfig__c triggerConfig = new TriggerConfig__c();
        triggerConfig.Name='Opportunity'; 
        triggerConfig.ApexHandler__c='careHandler'; 
        triggerConfig.IsActive__c=true;
        triggerConfig.SkipForUsers__c=null;
        insert triggerConfig;
     
        Care__c testCare = new Care__c(Name = 'Test Care');
        insert testCare;

      
        List<Opportunity> opportunities = new List<Opportunity>();
        for (Integer i = 1; i <= 500; i++) {
            opportunities.add(new Opportunity(
                Name = 'Test Opportunity ' + i,
                StageName = (i == 3) ? 'Closed Lost' : 'Closed Won',
                Amount = i * 100,
                CloseDate=System.today(),
                OPPCARE__c = testCare.Id
            ));
        }

        insert opportunities;

        for (Opportunity opp : opportunities) {
            opp.Amount = 20;
        }
        update opportunities;

      
       Care__c testCare2 = [SELECT Id, TotalOpportunityAmountAVG__c FROM Care__c WHERE Id = :testCare.Id];
        // Verify the TotalOpportunityAmountAVG__c field
        System.assertEquals(20, testCare2.TotalOpportunityAmountAVG__c);
    }
    

    @isTest
    static void testUpdateTotalOpportunityMax() {
        TriggerConfig__c triggerConfig = new TriggerConfig__c();
        triggerConfig.Name='Opportunity'; 
        triggerConfig.ApexHandler__c='careHandler'; 
        triggerConfig.IsActive__c=true;
        triggerConfig.SkipForUsers__c=null;
        insert triggerConfig;
    
        Care__c testCare = new Care__c(Name = 'Test Care');
        insert testCare;

        List<Opportunity> opportunities = new List<Opportunity>();

        for (Integer i = 1; i <= 500; i++) {
            opportunities.add(new Opportunity(
                Name = 'Test Opportunity ' + i,
                StageName = (i == 3) ? 'Closed Lost' : 'Closed Won',
                Amount = i * 100,
                CloseDate=System.today(),
                OPPCARE__c = testCare.Id
            ));
        }

        insert opportunities;

        for (Opportunity opp : opportunities) {
            opp.Amount = 20;
        }
        update opportunities;
        
         Care__c testCare3 = [SELECT Id, TotalOpportunityMax__c FROM Care__c WHERE Id = :testCare.Id];
        System.assertEquals(20, testCare3.TotalOpportunityMax__c);
    }

}