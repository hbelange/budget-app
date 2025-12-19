CREATE TABLE category_groups (
 id UUID PRIMARY KEY,
 user_id UUID NOT NULL,
 name VARCHAR(255) NOT NULL,
 sort_order INTEGER NOT NULL DEFAULT 0,
 CONSTRAINT fk_category_groups_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE categories (
    id UUID PRIMARY KEY,
    category_group_id UUID NOT NULL,
    name VARCHAR(255) NOT NULL,
    assigned DECIMAL(19, 2) NOT NULL DEFAULT 0.00,
    activity DECIMAL(19, 2) NOT NULL DEFAULT 0.00,
    available DECIMAL(19, 2) NOT NULL DEFAULT 0.00,
    sort_order INTEGER NOT NULL DEFAULT 0,
    CONSTRAINT fk_categories_group FOREIGN KEY (category_group_id) REFERENCES category_groups(id) ON DELETE CASCADE
);

CREATE INDEX idx_category_groups_user_id ON category_groups(user_id);
CREATE INDEX idx_categories_group_id ON categories(category_group_id);