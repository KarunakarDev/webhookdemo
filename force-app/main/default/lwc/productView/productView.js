import { LightningElement, wire } from 'lwc';
import getProducts from '@salesforce/apex/ProductController.getProducts';
import my_resource from '@salesforce/resourceUrl/prod1';
export default class ProductView extends LightningElement {

product;
preOrder = false;
productName;
image;
availbleInventory;
brand;
itemNumber;
my_image = my_resource;
price;
Qty =1;

@wire(getProducts)
wiredProducts({data, error}){
    if(data){
        this.productName = data.productName;
        this.preOrder = data.preOrder;
        //this.image = data.Image__c;
        this.product = data;
        this.availbleInventory = data.avlInvent;
        this.brand = data.brand;
        this.itemNumber = data.productCode;
        this.price = data.price;

    }
}

handleIncrement(){
    this.Qty = this.Qty+1;
}
handleDecrement(){
    if(Qty>1){
        this.Qty = this.Qty-1;
    }
    
}
handleAddToCart(){}
}