CREATE TABLE User (
    U_id INT PRIMARY KEY,
    Security_quest VARCHAR(100),
    Password VARCHAR(50)
);

CREATE TABLE Passenger (
    Pnr INT PRIMARY KEY,
    P_id INT,
    P_fname VARCHAR(50),
    P_mname VARCHAR(50),
    P_lname VARCHAR(50),
    P_age INT,
    P_sex VARCHAR(10),
    FOREIGN KEY (P_id) REFERENCES User(U_id)
);

CREATE TABLE Train (
    Train_no INT PRIMARY KEY,
    Train_name VARCHAR(100),
    Train_type VARCHAR(50),
    Avail_class VARCHAR(50)
);

CREATE TABLE Train_Status (
    Status_id INT PRIMARY KEY,
    Wait_seat INT,
    Status_uid INT,
    Booked_seat INT,
    FOREIGN KEY (Status_uid) REFERENCES Train(Train_no)
);

CREATE TABLE Station (
    Stn_id VARCHAR(10) PRIMARY KEY,
    Stn_name VARCHAR(100)
);

CREATE TABLE Route (
    Route_id INT PRIMARY KEY,
    Train_no INT,
    Stn_id VARCHAR(10),
    Arr_time TIME,
    Stop_no INT,
    Depart_time TIME,
    FOREIGN KEY (Train_no) REFERENCES Train(Train_no),
    FOREIGN KEY (Stn_id) REFERENCES Station(Stn_id)
);
CREATE TABLE Booking (
    Booking_id INT PRIMARY KEY,
    U_id INT,
    Pnr INT,
    Status_id INT,
    Booking_date DATE,
    FOREIGN KEY (U_id) REFERENCES User(U_id),
    FOREIGN KEY (Pnr) REFERENCES Passenger(Pnr),
    FOREIGN KEY (Status_id) REFERENCES Train_Status(Status_id)
);

INSERT INTO Train VALUES (1003, 'Duronto Express', 'Superfast', 'AC 1st Class, AC 2 Tier');
INSERT INTO Train VALUES (1004, 'Garib Rath', 'Express', 'AC 3 Tier');
INSERT INTO Train VALUES (1005, 'Jan Shatabdi', 'Superfast', 'Second Sitting, AC Chair Car');
INSERT INTO Train VALUES (1006, 'Intercity Express', 'Express', 'Sleeper, Second Sitting');
INSERT INTO Train VALUES (1007, 'Tejas Express', 'Premium', 'Executive Chair Car, AC Chair Car');

INSERT INTO Train_Status VALUES (3, 10, 70, 1003);
INSERT INTO Train_Status VALUES (4, 2, 78, 1004);
INSERT INTO Train_Status VALUES (5, 5, 95, 1005);
INSERT INTO Train_Status VALUES (6, 0, 120, 1006);
INSERT INTO Train_Status VALUES (7, 8, 80, 1007);


-- Duronto Express (1003)
INSERT INTO Route VALUES (1003, 1, '05:30:00', '05:35:00');
INSERT INTO Route VALUES (1003, 2, '08:30:00', '08:40:00');
INSERT INTO Route VALUES (1003, 3, '11:45:00', '11:50:00');

-- Garib Rath (1004)
INSERT INTO Route VALUES (1004, 1, '06:00:00', '06:10:00');
INSERT INTO Route VALUES (1004, 2, '10:00:00', '10:05:00');
INSERT INTO Route VALUES (1004, 3, '14:00:00', '14:10:00');

-- Jan Shatabdi (1005)
INSERT INTO Route VALUES (1005, 1, '07:15:00', '07:20:00');
INSERT INTO Route VALUES (1005, 2, '09:30:00', '09:35:00');
INSERT INTO Route VALUES (1005, 3, '12:00:00', '12:05:00');

-- Intercity Express (1006)
INSERT INTO Route VALUES (1006, 1, '06:45:00', '06:50:00');
INSERT INTO Route VALUES (1006, 2, '09:00:00', '09:05:00');
INSERT INTO Route VALUES (1006, 3, '11:15:00', '11:20:00');

-- Tejas Express (1007)
INSERT INTO Route VALUES (1007, 1, '05:50:00', '05:55:00');
INSERT INTO Route VALUES (1007, 2, '08:00:00', '08:05:00');
INSERT INTO Route VALUES (1007, 3, '10:30:00', '10:35:00');

-- Search Trains from Route
SELECT Train.Train_no, Train_name, Train_Type
FROM Train
JOIN Route ON Train.Train_no = Route.Train_no
WHERE Route.Stop_no = 1;

-- Check Seat Availability
SELECT Train_name, Wait_seat, Booked_seat
FROM Train_Status
JOIN Train ON Train_Status.Status_uid = Train.Train_no;

-- Book ticket simulatoin
UPDATE Train_Status
SET Booked_seat = Booked_seat + 1
WHERE Status_uid = 1001;

--  Show Full Route of Train

SELECT R.Stop_no, S.Stn_code, R.Arr_time, R.Depart_time
FROM Route R
JOIN Train T ON T.Train_no = R.Train_no
JOIN Station S ON S.Stn_id = 'NDLS'
WHERE R.Train_no = 1001
ORDER BY R.Stop_no;

-- Show Passengers for a User
SELECT P.P_name, P.P_age, P.P_sex
FROM Passenger P
JOIN User U ON P.P_id = U.U_id
WHERE U.U_id = 1;


