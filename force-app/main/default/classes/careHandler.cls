public with sharing class careHandler implements iTrigger {
    private static Boolean isAndFinallyExecuted = false;
    private static Set<Id> processedCareIds = new Set<Id>();

    List<Care__c> caresToUpdate = new List<Care__c>();

    public void bulkBefore() {
       
    }

    public void bulkAfter() {
        
        caresToUpdate = [Select NAME, TotalOpportunitySUM__c, (select Name, Amount, CloseDate, StageName
                                                             from Opportunities__r where Amount != Null)
                        from Care__c];
    }

    public void beforeInsert(sObject so) {
    }

    public void beforeUpdate(sObject oldSo, sObject so) {
    }

    public void beforeDelete(sObject so) {
    }

    public void afterInsert(SObject so) {
    }

    public void afterUpdate(SObject oldSo, SObject so) {
    }

    public void afterDelete(SObject so) {
    }

    public void andFinally() {
 
        if (!isAndFinallyExecuted) {
            
            isAndFinallyExecuted = true;
        
            caresToUpdate = careHelper.updateTotalOpportunity(caresToUpdate);
            caresToUpdate = careHelper.updateTotalOpportunityAvg(caresToUpdate);
            caresToUpdate = careHelper.updateTotalOpportunityMax(caresToUpdate);
        
            update caresToUpdate;
            
            processedCareIds.clear();
            isAndFinallyExecuted = false;
        }
    }
}
