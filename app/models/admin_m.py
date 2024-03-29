from app import mysql
import string
import random
from flask_mail import Message
from app import mail
from werkzeug.security import generate_password_hash

class admin():

    @staticmethod
    def get_user(admin_id):
        cursor = mysql.connection.cursor()
        query = "SELECT first_name, user_role FROM users WHERE id = %s"
        cursor.execute(query, (admin_id,))
        firstname = cursor.fetchone()
        cursor.close()
        return firstname 

    def get_users():
        cursor = mysql.connection.cursor()
        get_query = "SELECT * FROM users"
        cursor.execute(get_query)
        users = cursor.fetchall()

        user_list = []
        for user in users:
            user_dict = {
                'id': user[0],
                'username': user[1],
                'password': user[2],
                'first_name': user[3],
                'middle_name': user[4],
                'last_name': user[5],
                'email': user[6],
                'gender': user[7],
                'user_role': user[8]
                
            }
            user_list.append(user_dict)

        cursor.close()

        return user_list

    def check_existing_user(username,first_name, middle_name, last_name, email):
        cursor = mysql.connection.cursor()

        check_duplicate_sql = "SELECT * FROM users WHERE username = %s OR (first_name = %s AND middle_name = %s AND last_name = %s) OR email = %s"
        cursor.execute(check_duplicate_sql, (username, first_name, middle_name, last_name, email))
        existing_user = cursor.fetchone()

        if existing_user:
            return True
        
        else:
            return None

    def add_user(self, admin_username):
        cursor = mysql.connection.cursor()

        check_duplicate_sql = "SELECT * FROM users WHERE username = %s"
        cursor.execute(check_duplicate_sql, (self.username,))
        existing_user = cursor.fetchone()

        if existing_user:
            return False

        sql1 = """
        INSERT INTO users (username, password, first_name, middle_name, last_name, email, gender, user_role) 
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s);
        """
        cursor.execute(sql1, (self.username, self.password, self.first_name, self.middle_name, self.last_name, self.email, self.gender, self.user_role))

        sql_record = """
        CALL rec_admin_add(%s, %s);
        """
        cursor.execute(sql_record, (admin_username, self.username))

        mysql.connection.commit()
        
        return True
    
    def generate_password(length=12):
        special_characters = "!@#$%^&*-_+<>?"
        characters = string.ascii_letters + string.digits + special_characters
        password = ''.join(random.choice(characters) for _ in range(length))
        return password

    def send_message(email, password):
        message = Message(
            subject='CMS User Account',
            recipients=[email],
            sender=('Admin', 'cms_admin@gmail.com')
        )
        
        message.html = "<p>Account Password in CMS</p><p>Password: {}</p>".format(password)
        mail.send(message)
        
        return None


    def delete_user_record(user_id,admin_username):
        cursor = mysql.connection.cursor()

        fetch_username_query = "SELECT username FROM users WHERE id = %s"
        cursor.execute(fetch_username_query, (user_id,))
        username_tuple = cursor.fetchone()
        username = username_tuple[0]

        # Delete the user record
        delete_query = "DELETE FROM users WHERE id = %s"
        cursor.execute(delete_query, (user_id,))

        sql_record = """
        CALL rec_admin_delete(%s, %s);
        """
        cursor.execute(sql_record, (admin_username, username))

        mysql.connection.commit()
        cursor.close()

        return True
    
    @staticmethod
    def get_user_info(user_id):
        cursor = mysql.connection.cursor()
        query = "SELECT * FROM users WHERE id = %s"
        cursor.execute(query, (user_id,))
        user = cursor.fetchone()

        return user
    
    @staticmethod
    def update_user(user_id, username, password, first_name, middle_name, last_name, gender, user_role,admin_username, new_password=None,):
        cursor = mysql.connection.cursor()

        if new_password:
            
            email = admin.get_user_info(user_id)[6]  
            admin.send_message(email, new_password)

            hashed_password = generate_password_hash(new_password)

            sql = "UPDATE users SET username=%s, password=%s, first_name=%s, middle_name=%s, last_name=%s, gender=%s, user_role=%s WHERE id=%s"
            cursor.execute(sql, (username, hashed_password, first_name, middle_name, last_name, gender, user_role, user_id))

        else:
            # Update the database without changing the password
            sql = "UPDATE users SET username=%s, first_name=%s, middle_name=%s, last_name=%s, gender=%s, user_role=%s WHERE id=%s"
            cursor.execute(sql, (username, first_name, middle_name, last_name, gender, user_role, user_id))
            

        sql_record = """
        CALL rec_admin_edit(%s, %s);
        """
        cursor.execute(sql_record, (admin_username, username))  
          
        mysql.connection.commit()
        cursor.close()

        return True
    
    @staticmethod
    def get_all_logs():
        cursor = mysql.connection.cursor(dictionary=True)
        query = "SELECT * FROM user_logs ORDER BY log_date DESC, log_time DESC"
        cursor.execute(query)
        logs = cursor.fetchall()
        cursor.close()
        return logs