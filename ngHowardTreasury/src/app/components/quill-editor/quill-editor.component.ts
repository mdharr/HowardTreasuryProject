import { Component, Input } from '@angular/core';

@Component({
  selector: 'app-quill-editor',
  templateUrl: './quill-editor.component.html',
  styleUrls: ['./quill-editor.component.css']
})
export class QuillEditorComponent {
  @Input() editorContent: string = '';
}
