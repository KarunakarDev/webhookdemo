import { LightningElement } from 'lwc';

export default class HelloConditionalRender extends LightningElement {

    isVisible = false;
    handleClick(){
        this.isVisible = true;
    }
}