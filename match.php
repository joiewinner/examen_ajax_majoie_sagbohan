<?php

try {
    // Connexion à la base de données
    $db = new PDO('mysql:host=localhost;dbname=db_score', 'root', '');
    //echo 'Connexion réussie ';
} catch (PDOException $e) {
    die('Erreur de connexion à la base de données: ' . $e->getMessage());    
}

// Si le formulaire est soumis
if (isset($_POST['submit'])) {
    // Récupérer les données du formulaire
    $date_match = $_POST['date_match'];
    $score_dom = $_POST['score_dom'];
    $score_visit = $_POST['score_visit'];
    $stade = $_POST['stade'];

    // Préparer la requête SQL pour insérer les données dans la table 'Matchs'
    $sql = "INSERT INTO matchs (date_match, score_dom, score_visit, stade) VALUES (:date_match, :score_dom, :score_visit, :stade)";
    $param = $db->prepare($sql);

    $param->bindParam(':date_match', $date_match);
    $param->bindParam(':score_dom', $score_dom);
    $param->bindParam(':score_visit', $score_visit);
    $param->bindParam(':stade', $stade);

    // Exécuter la requête SQL
    if ($param->execute()) {
        echo "Score du match enregistré avec succès!";
    } else {
        echo "Erreur lors de l'enregistrement du score du match: " . $db->error;
    }
}

function getMatchs() {

    // Préparer la requête SQL
    $sql = "SELECT * FROM matchs";
    $result = $db->query($sql);

    // Si la requête est réussie
    if ($result->num_rows > 0) {
        $matchs = array();
        while ($row = $result->fetch()) {
            $matchs[] = $row;
        }

        // Encoder la liste des matchs en JSON
        $json_data = json_encode($matchs);
        echo $json_data;
    } else {
        echo json_encode(array("error" => "Aucun match trouvé"));
    }

}

if (isset($_GET['ajax']) && $_GET['ajax'] == 'getMatchs') {
    getMatchs();
    exit;
}

?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Enregistrer le score d'un match</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script>
        function getMatchs() {
            $.ajax({
                url: "<?php echo $_SERVER['PHP_SELF']; ?>?ajax=getMatchs",
                method: "GET",
                dataType: "json",
                success: function(data) {
                    if (data.error) {
                        $("#liste-matchs").html("<p>Aucun match trouvé.</p>");
                    } else {
                        var html = "";
                        for (var i = 0; i < data.length; i++) {
                            html += "<div class='match'><div class'card'>";
                            html += "    <div class'card-body'><h4>" + data[i]['date_match'] + "</h4>";
                            html += "    <p><strong>Score: " + data[i]['score_dom'] + " - " + data[i]['score_visit'] + "</strong></p>";
                            html += "    <p><strong>Score: " + data[i]['stade'] + "</strong></p>";
                            html += "</div></div></div>";
                        }
                        $("#liste-matchs").html(html);
                    }
                }
            });
        }

        $(document).ready(function() {
            getMatchs();

            $("form").submit(function(event) {
                event.preventDefault();
                getMatchs();
            });
        });
    </script> 
</head>
<body>
    <div class="container w-50">
        <h3>Enregistrer le score d'un match</h3>

        <form method="post" action="<?php echo $_SERVER['PHP_SELF']; ?>">
            <div class="form-group">
                <label for="date_match">Date du match:</label>
                <input type="date" id="date_match" name="date_match" class="form-control" required>
            </div>

            <div class="form-group">
                <label for="score_dom">Score équipe à domicile:</label>
                <input type="number" id="score_dom" name="score_dom" min="0" class="form-control" >
            </div>

            <div class="form-group">
                <label for="score_visit">Score équipe visiteur:</label>
                <input type="number" id="score_visit" name="score_visit" min="0" class="form-control" >
            </div>

            <div class="form-group">
                <label for="stade">Stade:</label>
                <input type="text" id="stade" name="stade" class="form-control" >
            </div>

            <div class="form-group">
                <input type="submit" name="submit" value="Enregistrer" class="btn btn-success text-center">
            </div>
        </form>
    </div>
    <br>
    <div id="liste-matchs"></div>   
</body>
</html>