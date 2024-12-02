import { RouterModule, Routes } from '@angular/router';
import { HomeComponent } from './home/home.component'
import { ProfileComponent } from './profile/profile.component';
import { NgModule } from '@angular/core';

export const routes: Routes = [
    { path: '', component: HomeComponent, pathMatch: 'full'},
    { path: 'profile', component: ProfileComponent}
];

// @NgModule({
//     imports: [RouterModule.forRoot(routes)],
//     exports: [RouterModule]
// })
// export class AppRoutingModule {}
