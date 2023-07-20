public with sharing class careHelper {

  public static List<Care__c> updateTotalOpportunity(List<Care__c> listOfCares) {
    // Update the TotalOpportunityAmount field for each related Care record
    for (Care__c care : listOfCares){
      Decimal totalAmount = 0;
      for (Opportunity opp : care.Opportunities__r){
        totalAmount = totalAmount + opp.Amount;
      }
      care.TotalOpportunitySUM__c = totalAmount;
    }
    return listOfCares;
  }

  public static List<Care__c> updateTotalOpportunityAvg(List<Care__c> listOfCares) {
    for (Care__c care : listOfCares){
      Decimal totalAmount = 0;
      Integer numOpportunities = care.Opportunities__r.size();
      for (Opportunity opp : care.Opportunities__r){
        totalAmount += opp.Amount;
      }
      if (numOpportunities > 0){
        care.TotalOpportunityAmountAVG__c = totalAmount / numOpportunities;
      } else{
        care.TotalOpportunityAmountAVG__c = 0;
      }
    }
    return listOfCares;
  }

  public static List<Care__c> updateTotalOpportunityMax(List<Care__c> listOfCares) {
    for (Care__c care : listOfCares){
      Decimal maxAmount = 0;
      for (Opportunity opp : care.Opportunities__r){
        if (opp.Amount > maxAmount){
          maxAmount = opp.Amount;
        }
      }
      care.TotalOpportunityMax__c = maxAmount;
    }
    return listOfCares;
  }

}
