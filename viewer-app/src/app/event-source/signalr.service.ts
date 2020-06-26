import {Injectable} from '@angular/core';
import * as SignalR from '@aspnet/signalr';

@Injectable()
export class SignalRService {

    private hubConnection: SignalR.HubConnection;
    events: string[] = [];

    constructor() {
        this.hubConnection = new SignalR.HubConnectionBuilder()
        .withUrl("http://localhost:7071/api")
        .build();
    }

    startReceiving() {
        this.hubConnection
            .start();

        this.hubConnection.on("newEvent", (event) => {
            this.events.push(event);
        });
    }
}