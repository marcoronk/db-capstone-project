CREATE DEFINER=`metauser`@`%` PROCEDURE `AddBooking`(p_BookingID INT, p_CustomerID INT,p_TableNumber INT, p_BookingDate DATE )
BEGIN

INSERT INTO Bookings(BookingID,CustomerID,TableNumber,Date) VALUES (p_BookingID, p_CustomerID, p_TableNumber, DATE(p_BookingDate));
SELECT CONCAT('New booking added') AS 'Confirmation';
END

CREATE DEFINER=`metauser`@`%` PROCEDURE `AddValidBooking`(p_BookingDate DATE, p_TableNumber int)
BEGIN

DECLARE v_tablestatus INT;

    -- Start the transaction
    START TRANSACTION;

    -- Check if the table is already booked on the specified date
    SELECT COUNT(*)
    INTO v_tablestatus
    FROM Bookings
    WHERE Date = DATE(p_BookingDate) AND TableNumber = p_TableNumber;

    -- Insert a new booking record if the table is available
    IF v_tablestatus = 0 THEN
        INSERT INTO Bookings (Date, TableNumber)
        VALUES (p_BookingDate, p_TableNumber);

        -- Commit the transaction if the insert is successful
        COMMIT;
        SELECT CONCAT('Table ',p_TableNumber,' - Booking added successfully for ',p_BookingDate) AS 'Booking Status';
    ELSE
        -- Rollback the transaction if the table is already booked
        ROLLBACK;
        SELECT CONCAT('Table ',p_TableNumber, ' is already booked - booking cancelled') AS 'Booking Status';
    END IF;

END


CREATE DEFINER=`metauser`@`%` PROCEDURE `CancelBooking`(p_BookingID INT)
BEGIN
DELETE FROM Bookings WHERE BookingID = p_BookingID;
SELECT CONCAT('Booking ', p_BookingID, ' cancelled') AS 'Confirmation';
END


PREPARE GetOrderDetail FROM
'SELECT Orders.OrderID, Orders.OrderQuantity,Orders.TotalCost 
FROM Orders JOIN Customers USING(CustomerID)
WHERE Customers.CustomerID = ? ;'

