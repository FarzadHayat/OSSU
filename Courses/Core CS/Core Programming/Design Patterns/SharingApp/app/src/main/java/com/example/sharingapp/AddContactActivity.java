package com.example.sharingapp;

import android.content.Context;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;

/**
 * Add a new contact
 */
public class AddContactActivity extends AppCompatActivity {

    private ContactList contactList = new ContactList();
    private ContactListController contactListController = new ContactListController(contactList);

    private Context context;

    private EditText username;
    private EditText email;

    private String username_str;
    private String email_str;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_add_contact);

        username = (EditText) findViewById(R.id.username);
        email = (EditText) findViewById(R.id.email);

        context = getApplicationContext();
        contactListController.loadContacts(context);
    }

    public void saveContact(View view) {

        username_str = username.getText().toString();
        email_str = email.getText().toString();

        if (!validateInput()) {
            return;
        }

        Contact contact = new Contact(username_str, email_str, null);

        // Add contact
        boolean success = contactListController.addContact(contact, context);
        if (!success){
            return;
        }

        // End AddContactActivity
        finish();
    }

    public boolean validateInput() {

        if (username_str.equals("")) {
            username.setError("Empty field!");
            return false;
        }

        if (email_str.equals("")) {
            email.setError("Empty field!");
            return false;
        }

        if (!email_str.contains("@")){
            email.setError("Must be an email address!");
            return false;
        }

        if (!contactListController.isUsernameAvailable(username_str)){
            username.setError("Username already taken!");
            return false;
        }

        return true;
    }
}
