import { LightningElement } from 'lwc';

export default class QuizAppLWC extends LightningElement {

    selected = {} // for answers
    correctAnswers = 0;
    isSubmitted = false;
    myQuestions = [
        {
            id:"Q1",
            Que:"Which one of the following is not a template loop",
            answer:{
                a : "for-each",
                b : "iterator",
                c : "map-loop"
            },
            crrectAns : "c"
        },
        {
            id:"Q2",
            Que:"Which one of file is invalid in LWC component folder",
            answer:{
                a : ".svg",
                b : ".apex",
                c : ".js"
            },
            crrectAns : "b"
        },
        {
            id:"Q3",
            Que:"Which one of the following is not a directive",
            answer:{
                a : "for-each",
                b : "if-true",
                c : "@track"
            },
            crrectAns : "c"
        }
    ]

    get allNotSelected(){
        return !(Object.keys(this.selected).length === this.myQuestions.length)
    }

    changeHandler(event){
        console.log("name",event.target.name);
        console.log("value", event.target.value);
        const {name, value} = event.target;
        this.selected = {...this.selected, [name]:value};
        console.log(this.selected);
    }

    submitHandler(event){
        event.preventDefault();
        
        let correct = this.myQuestions.filter(item => this.selected[item.id] === item.crrectAns);
        this.correctAnswers = correct.length;
        this.isSubmitted = true;
        console.log("this.correctAnswers", this.correctAnswers);
    }

    resetHandler(){
        this.selected = {};
        this.correctAnswers = 0;
        this.isSubmitted = false;
    }
}