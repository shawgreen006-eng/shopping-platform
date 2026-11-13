CREATE TABLE products (
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    category VARCHAR(50) NOT NULL DEFAULT '其他',
    description VARCHAR(255) NOT NULL DEFAULT '',
    image_url VARCHAR(255) NOT NULL DEFAULT ''
);

INSERT INTO products (id, name, price, stock, category, description, image_url) VALUES
    (1, '折叠手机', 1099.90, 10, '手机数码', '折叠设计与宽阔屏幕，兼顾便携和沉浸体验。', '/products/foldable-phone.png'),
    (2, '无线鼠标', 59.90, 30, '电脑外设', '轻巧便携，适合日常办公和学习。', '/products/wireless-mouse.png'),
    (3, '机械键盘', 299.00, 15, '电脑外设', '紧凑布局与清晰手感，适合长时间输入。', '/products/mechanical-keyboard.png'),
    (4, '蓝牙耳机', 199.00, 20, '音频设备', '无线聆听，收纳和充电都很方便。', '/products/bluetooth-earbuds.png'),
    (5, '手机充电器', 89.00, 25, '手机配件', '小巧便携的 USB-C 手机充电器。', '/products/phone-charger.png'),
    (6, '笔记本支架', 129.00, 12, '电脑配件', '可调节高度，让桌面使用更舒适。', '/products/laptop-stand.png');
