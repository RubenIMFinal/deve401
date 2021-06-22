trigger triggerDetalleFactura on Detalle_Factura__c (before insert, before update) 
{
    if(trigger.isInsert)
    {
        handlerDetalleFactura.insertTrigger(trigger.new);
    }
    if(trigger.isUpdate)
    {
        handlerDetalleFactura.upadteTrigger(trigger.new);
    }
}