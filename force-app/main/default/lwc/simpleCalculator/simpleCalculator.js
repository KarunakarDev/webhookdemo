import { LightningElement,track } from 'lwc';

export default class SimpleCalculator extends LightningElement {
    @track currentResult;
    firstNumber;
    secondNumber;
    numberChangeHandler(event){
        const inputbox = event.target.name;
        if(inputbox === 'firstNumber'){
            this.firstNumber = event.target.value;
        }else if(inputbox === 'secondNumber'){
            this.secondNumber = event.target.value;
        }
    }

    addHandler(event){
        const firstN = parseInt(this.firstNumber);
        const secondN = parseInt(this.secondNumber);
        this.currentResult = 'Result of '+firstN+'+'+secondN+' is '+(firstN+secondN);
    }

    subHandler(event){
        const firstN = parseInt(this.firstNumber);
        const secondN = parseInt(this.secondNumber);
        this.currentResult = 'Result of '+firstN+'-'+secondN+' is '+(firstN-secondN);
    }
    

    mulHandler(event){
        const firstN = parseInt(this.firstNumber);
        const secondN = parseInt(this.secondNumber);
        this.currentResult = 'Result of '+firstN+'x'+secondN+' is '+(firstN*secondN);
    }
    

    divHandler(event){
        const firstN = parseInt(this.firstNumber);
        const secondN = parseInt(this.secondNumber);
        this.currentResult = 'Result of '+firstN+'/'+secondN+' is '+(firstN/secondN);
    }
    
}