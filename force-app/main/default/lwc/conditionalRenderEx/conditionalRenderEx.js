import { LightningElement,track } from 'lwc';

export default class ConditionalRenderEx extends LightningElement {

    @track displayDiv = false;
    @track cityList = ['Hyderabad','Banglore','Pune','Delhi'];
    showDivHandler(ev){
        this.displayDiv = ev.target.checked;
    }

}