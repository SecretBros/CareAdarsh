trigger careOpportunities on Opportunity (after update) {
    TriggerFactory.initiateHandler(Opportunity.sObjectType);
}