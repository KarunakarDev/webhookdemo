import { LightningElement, track, api } from 'lwc';
import saveFile from "@salesforce/apex/CsvDataUploader.saveFile";
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class LwcCsvDataUpload extends LightningElement {
    // Id of currently displayed record (component is only for display on record pages)
    @api recordId;

    // Title and Label displayed in UI
    @api title = 'Upload Quote Lines';
    @api label = 'CSV File';

    // state management to display spinners and the modal used while uploading the component
    @track ready = true;
    @track error = false;
    @track isLoading = false;
    @track uploading = false;
    @track uploadStep = '0';
    @track uploadMessage = '';
    @track uploadDone = '';
    @track uploadMessage = '';

    //data
    @track fileUploaded;
    @track fileContents;
    @track fileReader;

    handleFileChange1 = (event) =>{
        console.log('enter handle File Change')
        Promise.resolve(event.target.files)
        .then(files => {
            
            console.log('enter Promise Resolve')
            this.isLoading = true;
            this.uploading = true;
            this.uploadStep = "1";
            this.uploadMessage = 'Reading File';
            this.uploadDone = false;
            this.uploadError = false;

            console.log('Promise Resolve check if file lengh = 1')
            if(files.length !== 1){
                throw new Error("L42: Error accessing file -- " + 
                    (files.length === 0 ? 
                        'No file received' : 
                        'Multiple files received'
                    ));
            }
           
            this.fileUploaded = event.target.files; 
            console.log('Promise Resolve assigned File to this.fileUploaded')
        })
        .then( () =>{
            console.log('51: LwcCsvDataUpload file --> ')
            this.uploadStep = "2";
            this.uploadMessage = 'Extracting Data';
            
            var fileReader = new FileReader();
            console.log('56: LwcCsvDataUpload fileReader --> '+fileReader)
            fileReader.onloadend = (() =>{
                this.uploadStep = "3";
                this.uploadMessage = 'Updating Record';
                this.fileContents = fileReader.result;
                console.log('61: LwcCsvDataUpload fileContents --> '+this.fileContents)
                this.saveToFile();
            })          
            
            fileReader.readAsDataURL(this.fileUploaded[0]);
            console.log('67: LwcCsvDataUpload fileReader --> '+fileReader)
        })
        .then(() =>{
            this.uploadMessage = "Done";  
            this.uploadDone = true;       
            return new Promise(function(resolve, _reject){ 
                // eslint-disable-next-line @lwc/lwc/no-async-operation
                window.setTimeout(resolve, 1000); 
            }); 
        })
        .then( () => {
            this.closeModal();

            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'CSV Upload: Success',
                    message: 'Current records has been updated successfully',
                    variant: 'success'
                })
            );             
        })
        .catch(error => {
            this.uploadError = true;
            window.console.log(error);
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error while uploading File',
                        message: error.message,
                        variant: 'error',
                    }),
                );
        }); 
    }

    saveToFile() {
        alert('In saveToFile fileContents --> '+ this.recordId);
        console.log('In saveToFile Strigified fileContents --> '+ JSON.stringify(this.fileContents))
        saveFile({ base64Data: JSON.stringify(this.fileContents), parentId: this.recordId })
            .then(() => {
                this.isLoading = false;

                // this.fileName = this.fileName + ' - Uploaded Successfully';
                this.isTrue = false;
                this.showLoadingSpinner = false;


                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success!!',
                        message: ' - Uploaded Successfully!!!',
                        variant: 'success',
                    }),
                );
            })

            .catch(error => {
                this.uploadError = true;
                this.isLoading = false;
                window.console.log(error);
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error while uploading File',
                        message: error.message,
                        variant: 'error',
                    }),
                );
            }
        );
    }

    closeModal() {
        this.uploading = false;
        this.uploadStep = 0;
        this.uploadMessage = '';
        this.uploadDone = false;
        this.uploadError = false; 
        this.isLoading = false;      
    }

    handleFileChange(event){
        const file = event.target.files[0] 
        var reader = new FileReader() 
        reader.onload = () => { 
            this.fileContents = reader.result;
            console.log(this.fileContents) 
            
            this.saveToFile();
        } 
        reader.readAsText(file) 
        this.isLoading = true;
    }
    

}