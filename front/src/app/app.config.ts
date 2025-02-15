import { ApplicationConfig, provideZoneChangeDetection } from '@angular/core';
import { provideRouter, withViewTransitions } from '@angular/router';

import { routes } from './app.routes';
import { HTTP_INTERCEPTORS, provideHttpClient, withInterceptorsFromDi } from '@angular/common/http';
import { provideIonicAngular } from '@ionic/angular/standalone';
import { MiddlewareService } from './services/auth/middleware.service';

export const appConfig: ApplicationConfig = {
  providers: [
    provideZoneChangeDetection({ eventCoalescing: true }), 
    provideRouter(routes, withViewTransitions()),
    provideHttpClient(withInterceptorsFromDi()), 
    provideIonicAngular({}),
    {
      provide: HTTP_INTERCEPTORS,
      useClass: MiddlewareService,
      multi:true
    }
  ]
};
