import { RouterModule, Routes } from '@angular/router';
import { HomeComponent } from './pages/home/home.component'
import { ProfileComponent } from './pages/profile/profile.component';
import { SearchComponent } from './pages/search/search.component';

export const routes: Routes = [
    { path: '', component: HomeComponent, pathMatch: 'full' },
    { path: 'profile', component: ProfileComponent },
    {
        path: 'search', component: SearchComponent
    }
];
