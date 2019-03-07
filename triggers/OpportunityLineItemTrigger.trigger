
trigger OpportunityLineItemTrigger on OpportunityLineItem (before insert, after insert, after update) {
    
    OpportunityLineItem_Handler OppLiHandler = new OpportunityLineItem_Handler();
    if(trigger.isAfter && trigger.isinsert)
    {
        OppLiHandler.updateQuantityUsed(trigger.new);
    }
    if(trigger.isAfter && trigger.isUpdate)
    {
        OppLiHandler.updateQuantityUsed(trigger.new);
    }
}