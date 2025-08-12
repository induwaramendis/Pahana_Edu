package com.induwara.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.induwara.model.Customer;
import com.induwara.util.DBConnection;


public class CustomerDAO {

    public boolean addCustomer(Customer customer) {
        boolean isSuccess = false;
        try (Connection con = DBConnection.getConnection()) {
        	String sql = "INSERT INTO Customers (account_number, name, email, address, telephone) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setInt(1, customer.getAccountNumber());
            pst.setString(2, customer.getName());
            pst.setString(3, customer.getEmail());  // ✅ Add email
            pst.setString(4, customer.getAddress());
            pst.setString(5, customer.getTelephone());

            int row = pst.executeUpdate();
            isSuccess = row > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return isSuccess;
    }
    
 // Fetch customer by account number
    public Customer getCustomerByAccountNumber(int accountNumber) {
        Customer customer = null;
        try (Connection con = DBConnection.getConnection()) {
            String sql = "SELECT * FROM customers WHERE account_number = ?";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setInt(1, accountNumber);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                customer = new Customer();
                customer.setAccountNumber(rs.getInt("account_number"));
                customer.setName(rs.getString("name"));
                customer.setEmail(rs.getString("email"));
                customer.setAddress(rs.getString("address"));
                customer.setTelephone(rs.getString("telephone"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return customer;
    }

    // Update customer details
    public boolean updateCustomer(Customer customer) {
        try (Connection con = DBConnection.getConnection()) {
            String sql = "UPDATE customers SET name = ?,email = ?, address = ?, telephone = ? WHERE account_number = ?";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, customer.getName());
            pst.setString(2, customer.getEmail());
            pst.setString(3, customer.getAddress());
            pst.setString(4, customer.getTelephone());
            pst.setInt(5, customer.getAccountNumber());

            return pst.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Customer> getAllCustomers() {
        List<Customer> customers = new ArrayList<>();
        try (Connection con = DBConnection.getConnection()) {
            String sql = "SELECT * FROM customers";
            PreparedStatement pst = con.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                Customer customer = new Customer();
                customer.setAccountNumber(rs.getInt("account_number"));
                customer.setName(rs.getString("name"));
                customer.setEmail(rs.getString("email"));
                customer.setAddress(rs.getString("address"));
                customer.setTelephone(rs.getString("telephone"));
                customers.add(customer);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return customers;
    }


}

