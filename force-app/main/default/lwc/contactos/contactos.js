import { LightningElement, track } from 'lwc';
import getContactList from '@salesforce/apex/ContactController.getContactList';

export default class Contactos extends LightningElement {
    @track searchKey = '';
    @track contacts;
    @track error;

    handleKeyChange(event) {
        this.searchKey = event.target.value;
    }

    handleLoad() {
        getContactList({ searchKey: this.searchKey })
            .then(result => {
                this.contacts = result;
            })
            .catch(error => {
                this.error = error;
            });
    }
}