package ubicacion;

import org.codehaus.jackson.map.ObjectMapper;

import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;

public class AddressConverter {

    public GoogleResponse convertFromLatLong(String latlongString) throws IOException {

        ObjectMapper mapper = new ObjectMapper();
        GoogleResponse response = mapper.readValue(new URL("https://maps.googleapis.com/maps/api/geocode/json?latlng=" + latlongString + "&key=AIzaSyC8Q7FY6SzmEfpMTOcx2BTrnYaRkzX12Ik"), GoogleResponse.class);
        return response;
    }
}