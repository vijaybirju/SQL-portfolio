SELECT 
    COUNT(
        CASE 
            WHEN product LIKE 'TurboTax%' THEN 1 
            ELSE NULL 
        END
    ) AS turbotax_total,
    COUNT(
        CASE 
            WHEN product LIKE 'QuickBooks%' THEN 1 
            ELSE NULL 
        END
    ) AS quickbooks_total
FROM filed_taxes;
