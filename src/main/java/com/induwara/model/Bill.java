package com.induwara.model;

import java.util.List;

public class Bill {
    private int billId;
    private String customerEmail;
    private String customerPhone;
    private double total;
    private List<BillItem> items;
    private java.sql.Timestamp billDate;

    public int getBillId() {
        return billId;
    }

    public void setBillId(int billId) {
        this.billId = billId;
    }

    public String getCustomerEmail() {
        return customerEmail;
    }

    public void setCustomerEmail(String customerEmail) {
        this.customerEmail = customerEmail;
    }

    public String getCustomerPhone() {
        return customerPhone;
    }

    public void setCustomerPhone(String customerPhone) {
        this.customerPhone = customerPhone;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public List<BillItem> getItems() {
        return items;
    }

    public void setItems(List<BillItem> items) {
        this.items = items;
    }
    

public java.sql.Timestamp getBillDate() {
    return billDate;
}

public void setBillDate(java.sql.Timestamp billDate) {
    this.billDate = billDate;
}
}
