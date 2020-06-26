import { Component, OnInit } from '@angular/core';
import { SignalRService } from './event-source/signalr.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent implements OnInit {

  title = 'viewer-app';

  constructor(public eventSource: SignalRService) { }

  ngOnInit() {
    this.eventSource.startReceiving();
  }
}
