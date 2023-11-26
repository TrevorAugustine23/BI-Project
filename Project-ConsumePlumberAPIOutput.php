<?php
# *****************************************************************************
# Consume data from the Plumber API Output (using PHP) ----
#

// Function to make the API request and process the response
function makeApiRequest($params) {
    // Set the API endpoint URL
    $apiUrl = 'http://127.0.0.1:5022/rainfall';

    // Initiate a new cURL session/resource
    $curl = curl_init();

    // Set the cURL options
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($curl, CURLOPT_URL, $apiUrl . '?' . http_build_query($params));

    // Make a GET request
    $response = curl_exec($curl);

    // Check for cURL errors
    if (curl_errno($curl)) {
        $error = curl_error($curl);
        // Handle the error appropriately
        die("cURL Error: $error");
    }

    // Close cURL session/resource
    curl_close($curl);

    // Decode the JSON into normal text
    $data = json_decode($response, true);

    // Check if the response was successful
if (isset($data['0'])) {
    // API request was successful
    // Access the data returned by the API
    echo "Will it rain tomorrow?:<br>";

    // Process the data
    foreach ($data as $repository) {
        // Check if the index exists before accessing it
        if (isset($repository['0'])) {
            echo $repository['0'];
        }

        if (isset($repository['1'])) {
            echo $repository['1'];
        }

        if (isset($repository['2'])) {
            echo $repository['2'];
        }

        echo "<br>";
    }
} elseif (isset($data['message'])) {
    // API request returned an error with a message
    echo "API Error: " . $data['message'];
} else {
    // API request failed without a specific message
    echo "API Error: Unknown error";
}

}

// Initialize variables
$output = '';

// Check if the form is submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Get the form values
    $MinTemp = $_POST['MinTemp'];
    $MaxTemp = $_POST['MaxTemp'];
    $Rainfall = $_POST['Rainfall'];
    $Evaporation = $_POST['Evaporation'];
    $Sunshine = $_POST['Sunshine'];
    $WindGustDir = $_POST['WindGustDir'];
    $WindGustSpeed = $_POST['WindGustSpeed'];
    $WindDir9am = $_POST['WindDir9am'];
    $WindDir3pm = $_POST['WindDir3pm'];
    $WindSpeed9am = $_POST['WindSpeed9am'];
    $WindSpeed3pm = $_POST['WindSpeed3pm'];
    $Humidity9am = $_POST['Humidity9am'];
    $Humidity3pm = $_POST['Humidity3pm'];
    $Pressure9am = $_POST['Pressure9am'];
    $Pressure3pm = $_POST['Pressure3pm'];
    $Cloud9am = $_POST['Cloud9am'];
    $Cloud3pm = $_POST['Cloud3pm'];
    $Temp9am = $_POST['Temp9am'];
    $Temp3pm = $_POST['Temp3pm'];
    $RainToday = $_POST['RainToday'];
    $RISK_MM = $_POST['RISK_MM'];
    $RainTomorrow = $_POST['RainTomorrow'];

    // Set the parameters for the API request
    $params = array(
        'MinTemp' => $MinTemp,
        'MaxTemp' => $MaxTemp,
        'Rainfall' => $Rainfall,
        'Evaporation' => $Evaporation,
        'Sunshine' => $Sunshine,
        'WindGustDir' => $WindGustDir,
        'WindGustSpeed' => $WindGustSpeed,
        'WindDir9am' => $WindDir9am,
        'WindDir3pm' => $WindDir3pm,
        'WindSpeed9am' => $WindSpeed9am,
        'WindSpeed3pm' => $WindSpeed3pm,
        'Humidity9am' => $Humidity9am,
        'Humidity3pm' => $Humidity3pm,
        'Pressure9am' => $Pressure9am,
        'Pressure3pm' => $Pressure3pm,
        'Cloud9am' => $Cloud9am,
        'Cloud3pm' => $Cloud3pm,
        'Temp9am' => $Temp9am,
        'Temp3pm' => $Temp3pm,
        'RainToday' => $RainToday,
        'RISK_MM' => $RISK_MM,
        'RainTomorrow' => $RainTomorrow
    );

    // Make the API request and store the output
    ob_start(); // Start output buffering
    makeApiRequest($params);
    $output = ob_get_clean(); // Get the buffered output and clear the buffer
}

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RainFall Prediction</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        form {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            width: 100%;
            text-align: left;
        }

        h2 {
            text-align: center;
            color: #333;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #333;
        }

        input {
            width: 100%;
            padding: 8px;
            margin-bottom: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        input[type="submit"] {
            background-color: #4caf50;
            color: #fff;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }

        .output {
            margin-top: 20px;
            padding: 10px;
            background-color: #dff0d8;
            border: 1px solid #3c763d;
            border-radius: 4px;
            color: #3c763d;
        }
    </style>
</head>
<body>

    <h2 style="color: #333;">Rainfall Prediction Form</h2>

    <form method="post" action="<?php echo $_SERVER['PHP_SELF']; ?>">
        
        <label for="MinTemp">MinTemp:</label>
        <input type="text" name="MinTemp" value="15"><br>

        <label for="MaxTemp">MaxTemp:</label>
        <input type="text" name="MaxTemp" value="25"><br>

        <label for="Rainfall">Rainfall:</label>
        <input type="text" name="Rainfall" value="5"><br>

        <label for="Evaporation">Evaporation:</label>
        <input type="text" name="Evaporation" value="6"><br>

        <label for="Sunshine">Sunshine:</label>
        <input type="text" name="Sunshine" value="8"><br>

        <label for="WindGustDir">WindGustDir:</label>
        <input type="text" name="WindGustDir" value="N"><br>

        <label for="WindGustSpeed">WindGustSpeed:</label>
        <input type="text" name="WindGustSpeed" value="30"><br>

        <label for="WindDir9am">WindDir9am:</label>
        <input type="text" name="WindDir9am" value="NE"><br>

        <label for="WindDir3pm">WindDir3pm:</label>
        <input type="text" name="WindDir3pm" value="NW"><br>

        <label for="WindSpeed9am">WindSpeed9am:</label>
        <input type="text" name="WindSpeed9am" value="10"><br>

        <label for="WindSpeed3pm">WindSpeed3pm:</label>
        <input type="text" name="WindSpeed3pm" value="15"><br>

        <label for="Humidity9am">Humidity9am:</label>
        <input type="text" name="Humidity9am" value="60"><br>

        <label for="Humidity3pm">Humidity3pm:</label>
        <input type="text" name="Humidity3pm" value="40"><br>

        <label for="Pressure9am">Pressure9am:</label>
        <input type="text" name="Pressure9am" value="1010"><br>

        <label for="Pressure3pm">Pressure3pm:</label>
        <input type="text" name="Pressure3pm" value="1008"><br>

        <label for="Cloud9am">Cloud9am:</label>
        <input type="text" name="Cloud9am" value="5"><br>

        <label for="Cloud3pm">Cloud3pm:</label>
        <input type="text" name="Cloud3pm" value="3"><br>

        <label for="Temp9am">Temp9am:</label>
        <input type="text" name="Temp9am" value="18"><br>

        <label for="Temp3pm">Temp3pm:</label>
        <input type="text" name="Temp3pm" value="22"><br>

        <label for="RainToday">RainToday:</label>
        <input type="text" name="RainToday" value="No"><br>

        <label for="RISK_MM">RISK_MM:</label>
        <input type="text" name="RISK_MM" value="0"><br>

        <label for="RainTomorrow">RainTomorrow:</label>
        <input type="text" name="RainTomorrow" value="Yes"><br>

        <input type="submit" value="Submit">
    </form>

    <?php
    // Display the output only if the form is submitted
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        echo '<div class="output">';
        echo $output;
        echo '</div>';
    }
    ?>

</body>
</html>
