# API Service - wrapper for all http requests in your app. 
With this service you can
- add domain in one place
- add authorization token (bearer jwt etc)
- add global handler for all http success methods
- add global handler for all http error methods

## Full example 
```typescript
import { Inject, Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs/Observable';
import 'rxjs/add/observable/throw';
import 'rxjs/add/operator/catch';
import 'rxjs/add/operator/map';

@Injectable()
export class ApiService {

    public options: {};

    constructor(
        @Inject('DOMAIN') private _domain: string,
        private _http: HttpClient,
    ) {
        // set authorization token on component initialization
        this.setToken();
    }

    public get(url) {
        return this._http.get(`${ this._domain }${url}`, this.options)
            .map(res => this._handleSuccess(res, 'GET'))
            .catch(err => this._handleError(err, 'GET'));
    }

    public post(url, data?) {
        return this._http.post(`${ this._domain }${url}`, data || {}, this.options)
            .map(res => this._handleSuccess(res, 'POST'))
            .catch(err => this._handleError(err, 'POST'));
    }

    public delete(url) {
        return this._http.delete(`${ this._domain }${url}`, this.options)
            .map(res => this._handleSuccess(res, 'DELETE'))
            .catch(err => this._handleError(err, 'DELETE'));
    }

    public put(url, data?) {
        return this._http.put(`${ this._domain }${url}`, data || {}, this.options)
            .map(res => this._handleSuccess(res, 'PUT'))
            .catch(err => this._handleError(err, 'PUT'));
    }

    /**
     * Set Token from localStorage and create Authorization headers
     */
    public setToken() {
        if (!localStorage.token) {
            return false;
        }
        this.options = {
            headers: new HttpHeaders().set('Authorization', `Token ${localStorage.token}`),
        };
    }

    /**
     * Method for request with success: boolean response
     */
    private _handleSuccess(res: any, method: string): Observable<any> {
        if (res.success) {
            console.info(`${method} Status: Success!`);
        }
        return res;
    }

    /**
     * Method for parsing global http errors
     */
    private _handleError(err: any, action: string): Observable<any> {
        let message;
        // here can be some modal window or small pop-out
        console.error(`${action} Error: ${message}`);
        return Observable.throw(err);
    }
}
```

## Usage 
In your service
```typescript
import { Injectable } from '@angular/core';
import { ApiService } from './your_path/api.service';

@Injectable()
export class ApplesService {

  constructor(
    private _api: ApiService,
  ) { }

  public getApples () {
    return this._api.get(`/apples`);
  }

  public addApple (apple) {
    return this._api.post(`/apples`, apple);
  }
}
```

In your component
```typescript
import { Component } from '@angular/core';
import { AppleService } from 'your_path/apple.service.ts';

@Component({
  selector: 'apple',
  templateUrl: 'apple.component.html'
})

export class AppleComponent {

  public apples;
  public apple;

  constructor(
    private _appleService: AppleService
  ) {
  }

  public getApples() {
    this._appleService.getApples().subscribe(apples => this.apples = apples);
  }

  public addApple() {
    this._appleService.addApple(this.apple).subscribe(() => alert('success!'));
  }

}
```

## How to use with authorization
```typescript
export class AuthService {

  public user;

  constructor (
    private _api: ApiService,
  ) {}

  public login(username, password) {
    this._api.post(`/login`, {username, password}).subscribe(res => {
      LocalStorage.setItem('token', res.token);
      this._api.setToken();
    });
  }
}
```
