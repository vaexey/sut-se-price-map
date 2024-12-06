import { Component, OnInit } from '@angular/core';
import { HelloWorldService } from '../../services/hello-world.service';

@Component({
  selector: 'app-home',
  imports: [],
  templateUrl: './home.component.html',
  styleUrl: './home.component.scss'
})
export class HomeComponent implements OnInit {  
  helloWorldJson: string = ""
  message: string = ""
 

  constructor (
    private helloWorldService: HelloWorldService
  ) {}

  ngOnInit(): void {
    this.helloWorldService.getHelloWorld().subscribe((response) => {
        this.message = response.message
    })
  }
}
