import { HttpClientModule } from '@angular/common/http';
import { NgModule } from '@angular/core';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { BrowserModule } from '@angular/platform-browser';
import { MatToolbarModule } from '@angular/material/toolbar';
import { MatSidenavModule } from '@angular/material/sidenav';
import { MatIconModule } from '@angular/material/icon';
import { MatListModule } from '@angular/material/list';
import { MatSnackBarModule } from '@angular/material/snack-bar';
import { MatButtonModule } from '@angular/material/button';
import { MatMenuModule } from '@angular/material/menu';
import { MatDialogModule } from '@angular/material/dialog';
import { MatInputModule } from '@angular/material/input';
import { MatExpansionModule } from '@angular/material/expansion';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatCardModule } from '@angular/material/card';
import { MatSelectModule } from '@angular/material/select';
import { MatOptionModule } from '@angular/material/core';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatSliderModule } from '@angular/material/slider';
import { MatProgressBarModule } from '@angular/material/progress-bar';


import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { HomeComponent } from './components/home/home.component';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { NavbarComponent } from './components/navbar/navbar.component';
import { LogoutComponent } from './components/logout/logout.component';
import { LoginDialogComponent } from './components/login-dialog/login-dialog.component';
import { RegisterDialogComponent } from './components/register-dialog/register-dialog.component';
import { CollectionsComponent } from './components/collections/collections.component';
import { CollectionDetailsComponent } from './components/collection-details/collection-details.component';
import { StoriesComponent } from './components/stories/stories.component';
import { StoryDetailsComponent } from './components/story-details/story-details.component';
import { PoemsComponent } from './components/poems/poems.component';
import { PoemDetailsComponent } from './components/poem-details/poem-details.component';
import { CharactersComponent } from './components/characters/characters.component';
import { CharacterDetailsComponent } from './components/character-details/character-details.component';
import { MiscellaneaComponent } from './components/miscellanea/miscellanea.component';
import { MiscellaneaDetailsComponent } from './components/miscellanea-details/miscellanea-details.component';
import { SearchComponent } from './components/search/search.component';
import { SearchResultsComponent } from './components/search-results/search-results.component';
import { AboutComponent } from './components/about/about.component';
import { UserListsComponent } from './components/user-lists/user-lists.component';
import { UserProfileComponent } from './components/user-profile/user-profile.component';
import { AddToUserListDialogComponent } from './components/add-to-user-list-dialog/add-to-user-list-dialog.component';
import { ScrollToTopButtonComponent } from './components/scroll-to-top-button/scroll-to-top-button.component';
import { CreateUserListDialogComponent } from './components/create-user-list-dialog/create-user-list-dialog.component';
import { ToggleRedModeButtonComponent } from './components/toggle-red-mode-button/toggle-red-mode-button.component';
import { BlogPostsComponent } from './components/blog-posts/blog-posts.component';
import { BlogCommentsComponent } from './components/blog-comments/blog-comments.component';
import { CommentComponent } from './components/comment/comment.component';
import { SvgElementComponent } from './components/svg-element/svg-element.component';
import { EditorModule, TINYMCE_SCRIPT_SRC} from '@tinymce/tinymce-angular';
import { BlogPostCreationComponent } from './components/blog-post-creation/blog-post-creation.component';
import { IllustratorsComponent } from './components/illustrators/illustrators.component';
import { IllustratorDetailsComponent } from './components/illustrator-details/illustrator-details.component';
import { IllustratorCardComponent } from './components/illustrator-card/illustrator-card.component';
import { RecentPostsComponent } from './components/recent-posts/recent-posts.component';
import { StripHtmlPipe } from './pipes/strip-html.pipe';
import { AnimatedCardComponent } from './components/animated-card/animated-card.component';
import { ImageTooltipComponent } from './components/image-tooltip/image-tooltip.component';
import { ImageZoomDirective } from './directives/image-zoom.directive';
import { PostRecommendationComponent } from './components/post-recommendation/post-recommendation.component';
import { BlogPostEditComponent } from './components/blog-post-edit/blog-post-edit.component';
import { TruncatePipe } from './pipes/truncate.pipe';
import { JumpToPageDialogComponent } from './components/jump-to-page-dialog/jump-to-page-dialog.component';
import { UpdateUserDialogComponent } from './components/update-user-dialog/update-user-dialog.component';
import { TimeAgoPipe } from './pipes/time-ago.pipe';
import { VerificationComponent } from './components/verification/verification.component';
import { CustomSnackbarComponent } from './components/custom-snackbar/custom-snackbar.component';
import { ChatComponent } from './components/chat/chat.component';
import { WebSocketService } from './services/websocket.service';
import { WeirdTalesComponent } from './components/weird-tales/weird-tales.component';
import { ImageSliderComponent } from './components/image-slider/image-slider.component';
import { ImageCarouselComponent } from './components/image-carousel/image-carousel.component';
import { WeirdTalesDetailsComponent } from './components/weird-tales-details/weird-tales-details.component';
import { ImageGalleryComponent } from './components/image-gallery/image-gallery.component';
import { StripNonAlphanumericPipe } from './pipes/strip-non-alphanumeric.pipe';
import { StoryRecommendationComponent } from './components/story-recommendation/story-recommendation.component';
import { MarqueeComponent } from './components/marquee/marquee.component';
import { FullscreenImageComponent } from './components/fullscreen-image/fullscreen-image.component';
import { AdventureComponent } from './components/adventure/adventure.component';
import { PasswordResetRequestComponent } from './components/password-reset-request/password-reset-request.component';
import { PasswordResetComponent } from './components/password-reset/password-reset.component';
import { StoryVoteComponent } from './components/story-vote/story-vote.component';
import { ReactivateAccountRequestComponent } from './components/reactivate-account-request/reactivate-account-request.component';
import { SquishedImageComponent } from './components/squished-image/squished-image.component';
import { ProductComponent } from './components/product/product.component';
import { DelReyCollectionsComponent } from './components/del-rey-collections/del-rey-collections.component';
import { UiDividerComponent } from './components/ui-divider/ui-divider.component';
import { BookCoverComponent } from './components/book-cover/book-cover.component';
import { PageFlipComponent } from './components/page-flip/page-flip.component';
import { NgxChartsModule } from '@swimlane/ngx-charts';
import { ImageZoomComponent } from './components/image-zoom/image-zoom.component';

@NgModule({
  declarations: [
    AppComponent,
    HomeComponent,
    NavbarComponent,
    LogoutComponent,
    LoginDialogComponent,
    RegisterDialogComponent,
    CollectionsComponent,
    CollectionDetailsComponent,
    StoriesComponent,
    StoryDetailsComponent,
    PoemsComponent,
    PoemDetailsComponent,
    CharactersComponent,
    CharacterDetailsComponent,
    MiscellaneaComponent,
    MiscellaneaDetailsComponent,
    SearchComponent,
    SearchResultsComponent,
    AboutComponent,
    UserListsComponent,
    UserProfileComponent,
    AddToUserListDialogComponent,
    ScrollToTopButtonComponent,
    CreateUserListDialogComponent,
    ToggleRedModeButtonComponent,
    BlogPostsComponent,
    BlogCommentsComponent,
    CommentComponent,
    SvgElementComponent,
    BlogPostCreationComponent,
    IllustratorsComponent,
    IllustratorDetailsComponent,
    IllustratorCardComponent,
    RecentPostsComponent,
    StripHtmlPipe,
    AnimatedCardComponent,
    ImageTooltipComponent,
    ImageZoomDirective,
    PostRecommendationComponent,
    BlogPostEditComponent,
    TruncatePipe,
    JumpToPageDialogComponent,
    UpdateUserDialogComponent,
    TimeAgoPipe,
    VerificationComponent,
    CustomSnackbarComponent,
    ChatComponent,
    WeirdTalesComponent,
    ImageSliderComponent,
    ImageCarouselComponent,
    WeirdTalesDetailsComponent,
    ImageGalleryComponent,
    StripNonAlphanumericPipe,
    StoryRecommendationComponent,
    MarqueeComponent,
    FullscreenImageComponent,
    AdventureComponent,
    PasswordResetRequestComponent,
    PasswordResetComponent,
    StoryVoteComponent,
    ReactivateAccountRequestComponent,
    SquishedImageComponent,
    ProductComponent,
    DelReyCollectionsComponent,
    UiDividerComponent,
    BookCoverComponent,
    PageFlipComponent,
    ImageZoomComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    FormsModule,
    NgbModule,
    MatToolbarModule,
    MatSidenavModule,
    MatIconModule,
    MatListModule,
    MatButtonModule,
    BrowserAnimationsModule,
    MatSnackBarModule,
    MatMenuModule,
    MatInputModule,
    MatExpansionModule,
    MatDialogModule,
    MatProgressSpinnerModule,
    MatCheckboxModule,
    EditorModule,
    MatCardModule,
    MatOptionModule,
    MatFormFieldModule,
    MatSelectModule,
    MatSliderModule,
    MatProgressBarModule,
    ReactiveFormsModule,
    NgxChartsModule
  ],
  providers: [
    WebSocketService,
    { provide: TINYMCE_SCRIPT_SRC, useValue: '/tinymce/tinymce.min.js' }
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
