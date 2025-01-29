import { Routes } from '@angular/router';
import { HomeComponent } from './pages/home/home.component'
import { ProfileComponent } from './pages/profile/profile.component';
import { SearchComponent } from './pages/search/search.component';
import { LoginComponent } from './pages/login/login.component';
import { ErrorNotFoundComponent } from './pages/error-not-found/error-not-found.component';
import { OnlyLoggedService } from './services/only-logged.service';
import { OnlyAnonymousService } from './services/only-anonymous.service';
import { SignUpComponent } from './pages/sign-up/sign-up.component';
import { ErrorUnavailableComponent } from './pages/error-unavailable/error-unavailable.component';

export const routes: Routes = [
    { 
        path: 'login',
        component: LoginComponent,
        canActivate: [OnlyAnonymousService],
        title: "Price Compass - login",
    },
    { 
        path: 'sign-up',
        component: SignUpComponent,
        canActivate: [OnlyAnonymousService],
        title: "Price Compass - sign up",
    },
    { 
        path: 'profile',
        component: ProfileComponent,
        canActivate: [OnlyLoggedService],
        title: "Price Compass - profile",
    },
    { 
        path: 'search',
        component: SearchComponent ,
        title: "Price Compass - search",
    },

    {
        path: '503',
        component: ErrorUnavailableComponent,
        title: "Price Compass - failure",
    },

    { 
        path: '',
        pathMatch: 'full',
        component: HomeComponent,
        title: "Price Compass",
    },
    { 
        path: '**',
        pathMatch: 'full',
        component: ErrorNotFoundComponent,
        title: "Price Compass - not found",
    },
];
