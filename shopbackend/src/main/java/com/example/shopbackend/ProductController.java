package com.example.shopbackend;

import java.math.BigDecimal;
import java.util.List;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ProductController {
    private final JdbcTemplate jdbcTemplate;

    public ProductController(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @GetMapping("/api/products")
    public List<Product> products(@RequestParam(defaultValue = "") String keyword) {
        return jdbcTemplate.query(
                "SELECT id, name, price, stock, category, description, image_url "
                        + "FROM products WHERE name LIKE ? ORDER BY id",
                (rs, rowNum) -> new Product(
                        rs.getLong("id"),
                        rs.getString("name"),
                        rs.getBigDecimal("price"),
                        rs.getInt("stock"),
                        rs.getString("category"),
                        rs.getString("description"),
                        rs.getString("image_url")),
                "%" + keyword.trim() + "%");
    }

    public record Product(long id, String name, BigDecimal price, int stock,
                          String category, String description, String imageUrl) {}
}
