public with sharing class handlerDetalleFactura 
{
   
    public static void insertTrigger(list<Detalle_Factura__c> lstDetFactura) 
    {
        list<Account> clientes = new List<Account>();
        list<Factura__c> facturas = new List<Factura__c>();
        Set<Id> idFactura = new Set<Id>(); 
        Set<String> idCliente = new Set<string>();
        map<String, Factura__c> mapFactura = new map<String, Factura__c>();
        map<String, Account> mapAccount = new map<String, Account>();

        for(Detalle_Factura__c detFactura : lstDetFactura)
        {
            if(detFactura.Factura__c != null)
            {
                idFactura.add(detFactura.Factura__c);
            }
            if(detFactura.Cantidad__c > 0 && detFactura.Precio_unitario__c > 0)
            {
                detFactura.Precio__c = detFactura.Cantidad__c * detFactura.Precio_unitario__c;
            }else
            {
                if(detFactura.Cantidad__c <= 0)
                {
                    detFactura.Cantidad__c.addError('La cantidad tiene que ser mayor a 0! el valor actual es: '+detFactura.Cantidad__c);
                }   
                if(detFactura.Precio_unitario__c <= 0)
                {
                    detFactura.Precio_unitario__c.addError('El precio tiene que ser mayor a 0! el valor actual es: '+detFactura.Precio_unitario__c);
                }    
            }  
        }

        facturas = [Select id, Account__c, DNI__c From Factura__c Where id IN :idFactura];

        for(Factura__c factura : facturas)
        {
            if(factura.DNI__c != null)
            {
                mapFactura.put(factura.DNI__c, factura);
            }
        }

        for(Account cliente : [Select Id, DNI__c From Account Where DNI__c IN :mapFactura.keySet()])
        {
            mapAccount.put(cliente.DNI__c, cliente);
        }

        for(Factura__c factura : facturas)
        {
           if(mapAccount.containsKey(factura.DNI__c))
           {
               factura.Account__c = mapAccount.get(factura.DNI__c).id;
           }
        }
        update facturas;
    
    }

    public static void upadteTrigger(list<Detalle_Factura__c> lstDetFactura)
    {
        for(Detalle_Factura__c detFactura : lstDetFactura)
        {
            if(detFactura.Cantidad__c > 0 && detFactura.Precio_unitario__c > 0)
            {
                detFactura.Precio__c = detFactura.Cantidad__c * detFactura.Precio_unitario__c;
            }
        } 
    }
}