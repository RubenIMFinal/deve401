trigger triggerCrearTareaCallMeBack on Account (after update) {

   // TareaCallMeBack.crearTarea();
   for (Account acc :Trigger.New) {
       if(acc.Call_Me_Back__c == true){
            Task t = new Task();
            t.WhatID          = acc.Id;
            t.Ownerid         = acc.Ownerid;
            t.subject 	  = 'Tarea de ' + acc.Name;
            t.Status	  = 'In Progress';
            t.Description     = 'Tarea CallMeBack creada desde Trigger';
            insert t;

       }

    }
}