CREATE TABLE monthly_budgets (
 id UUID PRIMARY KEY,
 user_id UUID NOT NULL,
 month DATE NOT NULL,
 income DECIMAL(19, 2) NOT NULL DEFAULT 0.00,
 ready_to_assign DECIMAL(19, 2) NOT NULL DEFAULT 0.00,
 CONSTRAINT fk_monthly_budgets_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
 CONSTRAINT uk_monthly_budgets_user_month UNIQUE (user_id, month)
);

CREATE INDEX idx_monthly_budgets_user_id ON monthly_budgets(user_id);
CREATE INDEX idx_monthly_budgets_month ON monthly_budgets(month);