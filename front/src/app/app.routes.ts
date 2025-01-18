import { Routes } from '@angular/router';
import { HomeComponent } from './pages/home/home.component'
import { ProfileComponent } from './pages/profile/profile.component';
import { SearchComponent } from './pages/search/search.component';
import { LoginComponent } from './pages/login/login.component';
import { ErrorNotFoundComponent } from './pages/error-not-found/error-not-found.component';
import { OnlyLoggedService } from './services/only-logged.service';

export const routes: Routes = [
    { 
        path: 'login', 
        component: LoginComponent 
    },
    { 
        path: 'profile', 
        component: ProfileComponent,
        canActivate: [OnlyLoggedService]
    },
    { 
        path: 'search', 
        component: SearchComponent 
    },

    { path: '', pathMatch: 'full', component: HomeComponent },
    { path: '**',  pathMatch: 'full', component: ErrorNotFoundComponent },
];
