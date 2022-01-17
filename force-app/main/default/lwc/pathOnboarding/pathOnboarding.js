import { LightningElement, api, track} from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import accMainObject from '@salesforce/schema/Account';
import accFirstName from '@salesforce/schema/Account.Name';
import accLastName from '@salesforce/schema/Account.LastName__c';
import accEmail from '@salesforce/schema/Account.PersonEmail__c';
import accDni from '@salesforce/schema/Account.numDNI__c';
import accPhone from '@salesforce/schema/Account.Phone';

 
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
export default class pathOnboarding extends NavigationMixin(LightningElement) {
 
    firstName = '';
    lastName = '';
    emailId='';
    dni='';
    phone='';

    @api recordId;
    @track currentStep;

    goBackToStepOne() {
        this.currentStep = '1';

        this.template.querySelector('div.stepTwo').classList.add('slds-hide');
        this.template
            .querySelector('div.stepOne')
            .classList.remove('slds-hide');
    }

    goToStepTwo() {
        this.currentStep = '2';

        this.template.querySelector('div.stepOne').classList.add('slds-hide');
        this.template
            .querySelector('div.stepTwo')
            .classList.remove('slds-hide');
    }
    goBackToStepTwo() {
        this.currentStep = '2';

        this.template.querySelector('div.stepThree').classList.add('slds-hide');
        this.template
            .querySelector('div.stepTwo')
            .classList.remove('slds-hide');
    }

    goToStepThree() {
        //crear y llamar clase apex.comprobarDNI, si existe va a step 6. Si no existe, crear y llamar método crear cliente y continuar a step 3
        this.currentStep = '3';

        this.template.querySelector('div.stepTwo').classList.add('slds-hide');
        this.template
            .querySelector('div.stepThree')
            .classList.remove('slds-hide');
    }
    //para manejar el check
    value = [];

    get options() {
        return [
            { label: 'Acepto', value: 'option1' },

        ];
    }

    goBackToStepThree() {
        this.currentStep = '3';

        this.template.querySelector('div.stepFour').classList.add('slds-hide');
        this.template
            .querySelector('div.stepThree')
            .classList.remove('slds-hide');
    }
    

    goToStepFour(){
        //tras comprobar que ha seleccionado check, ir al step 4
        //crear e invocar clase.método que cree el contrato
        //crear invocar clase.método generar PDF y después pasar a step 4
        this.currentStep = '4';

        this.template.querySelector('div.stepThree').classList.add('slds-hide');
        this.template
            .querySelector('div.stepFour')
            .classList.remove('slds-hide');
    }
    
    crearCallmeBack(){

        //crear invocar clase.metodo crear tarea callmeback y después volver al step 1
        this.currentStep = '1';

        this.template.querySelector('div.stepTwo').classList.add('slds-hide');
        this.template
            .querySelector('div.stepOne')
            .classList.remove('slds-hide');        
    }

    recuperarProceso(){
        //crear invocar apex.método comprobar dni. Si existe, va al step 3 (contrato)
        this.currentStep = '3';

        this.template.querySelector('div.stepTwo').classList.add('slds-hide');
        this.template
            .querySelector('div.stepThree')
            .classList.remove('slds-hide');
    }


    accountChangeVal(event) {
        console.log(event.target.label);
        console.log(event.target.value);        
        if(event.target.label=='First Name'){
            this.firstName = event.target.value;
        }
        if(event.target.label=='Last Name'){
            this.lastName = event.target.value;
        }            
        if(event.target.label=='Email'){
            this.emailId = event.target.value;
        }        
    }

    insertAccountAction(){
        console.log(this.selectedAccountId);
        const fields = {};
        fields[accFirstName.fieldApiName] = this.firstName;
        fields[accLastName.fieldApiName] = this.lastName;
        fields[accEmail.fieldApiName] = this.emailId;
        fields[accDni.fieldApiName] = this.dni;
        fields[accPhone.fieldApiName] = this.phone;

       
        const recordInput = { apiName: accMainObject.objectApiName, fields };
        createRecord(recordInput)
            .then(accountobj=> {
                this.accountId = accountobj.id;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Account record has been created',
                        variant: 'success',
                    }),
                );
              /*  this[NavigationMixin.Navigate]({
                    type: 'standard__recordPage',
                    attributes: {
                        recordId: accountobj.id,
                        objectApiName: 'Account',
                        actionName: 'view'
                    },
                });*/
 
 
 
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating record',
                        message: error.body.message,
                        variant: 'error',
                    }),
                );
            });
    }
 
}