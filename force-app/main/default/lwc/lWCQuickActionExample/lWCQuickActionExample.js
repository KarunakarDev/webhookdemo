import { LightningElement, api } from 'lwc';
import { updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import DESCRIPTION_FIELD from '@salesforce/schema/Account.Description';
import ID_FIELD from '@salesforce/schema/Account.Id';

export default class QuickActionComponent extends LightningElement {

    @api recordId;

    @api invoke() {

        console.log( "Inside Invoke Method" );
        console.log( "Record Id is " + this.recordId );

        const fields = {};
        fields[ ID_FIELD.fieldApiName ] = this.recordId;
        fields[ DESCRIPTION_FIELD.fieldApiName] = 'Testing LWC Quick Action';

        const recordInput = {fields};

        updateRecord( recordInput )
        .then( () => {
            this.dispatchEvent(
                new ShowToastEvent( {
                    title: 'Success',
                    message: 'Account updated',
                    variant: 'success'
                } )
            );
        }).catch( error => {
            this.dispatchEvent(
                new ShowToastEvent( {
                    title: 'Error updating or reloading record',
                    message: error.body.message,
                    variant: 'error'
                } )
            );
        });

    }

}