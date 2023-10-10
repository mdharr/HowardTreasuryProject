import { Component, Inject } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';

@Component({
  selector: 'app-add-to-user-list-dialog',
  templateUrl: './add-to-user-list-dialog.component.html',
  styleUrls: ['./add-to-user-list-dialog.component.css']
})
export class AddToUserListDialogComponent {
  userLists: any[] = []; // Replace with your actual user lists data
  newUserListName: string = '';

  constructor(
    public dialogRef: MatDialogRef<AddToUserListDialogComponent>,
    @Inject(MAT_DIALOG_DATA) public data: any
  ) {}

  addToSelectedUserLists() {
    // Implement logic to add the current story to selected user lists
    // You can access selected lists using this.userLists array
    // Call an appropriate service or function to update the data
    this.dialogRef.close();
  }

  createNewUserList() {
    // Implement logic to create a new user list with this.newUserListName
    // You can add the new list to this.userLists array
    // Call an appropriate service or function to update the data
    this.newUserListName = ''; // Clear the input field
  }

}
