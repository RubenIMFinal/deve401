@RestResource(urlMapping='/sobjects/Task/*')
global with sharing class RestCallMeBack {

    //Autor: Rubén Izquierdo Molina.
    //Clase invocada por un servicio web de tipo post que le transmite los parámetros específicos.
    //Invocando a su vez a la clase "TareaCallMeBack" que realiza la lógica deseada con dichos parámetros.
    

    @HttpPost
    global static void restCrearTarea(String processType, String phone){
        System.debug('RIM rest call me back');
        System.debug('RIM rest processType : ' + processType);
        System.debug('RIM rest phone : ' + phone);


        TareaCallMeBack.crearTarea(processType, phone);

    }

}
