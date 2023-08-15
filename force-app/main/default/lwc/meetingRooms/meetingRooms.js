import { LightningElement } from 'lwc';
export default class MeetingRooms extends LightningElement {

    meetingroomsInfo = [
        {roomName : 'A-01', roomCapacity: 12},
        {roomName : 'A-02', roomCapacity: 6},
        {roomName : 'A-03', roomCapacity: 8},
        {roomName : 'B-01', roomCapacity: 9},
        {roomName : 'B-02', roomCapacity: 10},
        {roomName : 'C-01', roomCapacity: 4},
        {roomName : 'D-01', roomCapacity: 5},
        {roomName : 'D-02', roomCapacity: 12}
    ];
}