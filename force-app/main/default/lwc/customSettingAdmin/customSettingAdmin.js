import { LightningElement, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
//import getCustomSettings from '@salesforce/apex/CustomSettingHandler.getCustomSettings';

//Autor: Rubén Izquierdo Molina.c/pathOnboarding
//Pruebas para LWC de custom setting.

const FIELDS = [
    'AdminStep__c.Activo__c',
    'AdminStep__c.Codigo_Paso__c',
    'AdminStep__c.Fecha_Fin__c',
    'AdminStep__c.Fecha_Inicio__c',
    'AdminStep__c.Pasos__c',
];

export default class CustomSettingAdmin extends LightningElement {


   // recordId='m00B00000001hihIAA';
   recordId;
    
    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    metadatarecord;
    
    get activo() {
        return this.metadatarecord.data.fields.Activo__c.value;
    }

    get codigoPaso() {
        return this.metadatarecord.data.fields.Codigo_Paso__c.value;
    }

    get fechaFin() {
        return this.metadatarecord.data.fields.Fecha_Fin__c.value;
    }

    get fechaInicio() {
        return this.metadatarecord.data.fields.Fecha_Inicio__c.value;
    }

    get pasos() {
        return this.metadatarecord.data.fields.Pasos__c.value;
    }







   /* @wire(getCustomSettings) myCustomSettings;

    doSomething() {
        let a = this.myCustomSettings.data.Activo__c;
        // do something...
    }*/






}