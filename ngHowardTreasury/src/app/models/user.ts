export class User {

  id: number;
  username: string;
  password: string;
  confirmPassword: string;
  enabled: boolean;
  role: string;
  email: string;

  constructor(
    id: number = 0,
    username: string = '',
    password: string = '',
    confirmPassword: string = '',
    enabled: boolean = false,
    role: string = '',
    email: string = ''
  ) {
    this.id = id;
    this.username = username;
    this.password = password;
    this.confirmPassword = confirmPassword;
    this.enabled = enabled;
    this.role = role;
    this.email = email;
  }
}
