package com.induwara.dao;

import com.induwara.model.Bill;
import com.induwara.model.BillItem;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BillDAO {

    private final String url = "jdbc:mysql://127.0.0.1:3306/Pahana_Edu?useSSL=false";
    private final String user = "root";
    private final String pass = "g8VzsFBBl$m@Kx+";

    public int saveBill(Bill bill) throws Exception {
        int billId = -1;

        Connection con = DriverManager.getConnection(url, user, pass);
        String sql = "INSERT INTO Bill (customer_email, customer_phone, total) VALUES (?, ?, ?)";
        PreparedStatement pst = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        pst.setString(1, bill.getCustomerEmail());
        pst.setString(2, bill.getCustomerPhone());
        pst.setDouble(3, bill.getTotal());
        pst.executeUpdate();

        ResultSet rs = pst.getGeneratedKeys();
        if (rs.next()) {
            billId = rs.getInt(1);
        }

        String itemSql = "INSERT INTO BillItem (bill_id, item_id, item_name, quantity, unit_price, subtotal) VALUES (?, ?, ?, ?, ?, ?)";
        PreparedStatement itemStmt = con.prepareStatement(itemSql);

        for (BillItem item : bill.getItems()) {
            itemStmt.setInt(1, billId);
            itemStmt.setInt(2, item.getItemId());
            itemStmt.setString(3, item.getItemName());
            itemStmt.setInt(4, item.getQuantity());
            itemStmt.setDouble(5, item.getUnitPrice());
            itemStmt.setDouble(6, item.getSubtotal());
            itemStmt.addBatch();
        }

        itemStmt.executeBatch();
        con.close();
        return billId;
    }
    public List<Bill> getAllBills() throws Exception {
        List<Bill> bills = new ArrayList<>();

        Connection con = DriverManager.getConnection(url, user, pass);
        String sql = "SELECT * FROM Bill ORDER BY bill_date DESC";
        PreparedStatement pst = con.prepareStatement(sql);
        ResultSet rs = pst.executeQuery();

        while (rs.next()) {
            Bill bill = new Bill();
            bill.setBillId(rs.getInt("bill_id"));
            bill.setCustomerEmail(rs.getString("customer_email"));
            bill.setCustomerPhone(rs.getString("customer_phone"));
            bill.setTotal(rs.getDouble("total"));
            bill.setBillDate(rs.getTimestamp("bill_date"));
            bills.add(bill);
        }

        con.close();
        return bills;
    }
    public List<Bill> searchBills(String phone, String date) throws Exception {
        List<Bill> bills = new ArrayList<>();

        Connection con = DriverManager.getConnection(url, user, pass);

        StringBuilder sql = new StringBuilder("SELECT * FROM Bill WHERE 1=1");
        if (phone != null && !phone.isEmpty()) {
            sql.append(" AND customer_phone LIKE ?");
        }
        if (date != null && !date.isEmpty()) {
            sql.append(" AND DATE(bill_date) = ?");
        }

        PreparedStatement pst = con.prepareStatement(sql.toString());

        int index = 1;
        if (phone != null && !phone.isEmpty()) {
            pst.setString(index++, "%" + phone + "%");
        }
        if (date != null && !date.isEmpty()) {
            pst.setString(index++, date);
        }

        ResultSet rs = pst.executeQuery();

        while (rs.next()) {
            Bill bill = new Bill();
            bill.setBillId(rs.getInt("bill_id"));
            bill.setCustomerEmail(rs.getString("customer_email"));
            bill.setCustomerPhone(rs.getString("customer_phone"));
            bill.setTotal(rs.getDouble("total"));
            bill.setBillDate(rs.getTimestamp("bill_date"));
            bills.add(bill);
        }

        con.close();
        return bills;
    }



    
}
