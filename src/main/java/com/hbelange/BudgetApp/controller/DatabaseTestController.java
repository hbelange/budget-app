import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

@RestController
@RequestMapping("/api/test")
public class DatabaseTestController {

    @Autowired
    private DataSource dataSource;

    @GetMapping("/db-connection")
    public ResponseEntity<String> testConnection() {
        try (Connection connection = dataSource.getConnection()) {
            return ResponseEntity.ok("Database connection successful! " +
                    "Database: " + connection.getCatalog());
        } catch (SQLException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Database connection failed: " + e.getMessage());
        }
    }
}
