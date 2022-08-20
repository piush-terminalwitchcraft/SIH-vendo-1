import Button from "react-bootstrap/Button";
import Navbar from "../components/Navbar2";
import axios from "axios";
import {
  GoogleMap,
  LoadScript,
  MarkerF,
  Autocomplete,
} from "@react-google-maps/api";
import React from "react";

function VendorApplicationDetails({ VendorDetails }) {
  console.log(VendorDetails);
   /**
   * Vendor Params
   * vendorId
   * name
   * dob
   * gender
   * address
   * phone
   * aadharNo
   * panCardNo
   * isPassport
   * isElectionid
   * isMcgmLicense
   * aadharcardImageUrl
   * pancardImageUrl
   * shopLocationAddress
   * shopLocationLat
   * shopLocationLong
   * vendingZoneIdApplied
   * shopCity
   * creditScore
   * vendorImageurl
   * isApproved
   * complaintsList
   * reviewList
   * weeklyBazzarList
   * vendorCategory
   * shopName
   */
    const containerStyle = {
      // width: '800px',
      height: "400px",
      marginTop: "20px",
    };
    
    const [center, setCenter] = React.useState({
      lat: VendorDetails.shopLocationLat%90,
      lng: VendorDetails.shopLocationLong%90,
    });
    const [position, setPosition] = React.useState({
      lat: VendorDetails.shopLocationLat%90,
      lng: VendorDetails.shopLocationLong%90,
    });
  return (
    <div>
      <Navbar />
      <div className="pending-application-container">
        <div className="pending-application-container-item">
          <Button variant="primary" className="pending-application-banner">
            Application ID - {VendorDetails.vendorId}
          </Button>{" "}
          <div className="pending-application-section-title">Vendor Name </div>
          <div className="pending-application-section-desc">
            {VendorDetails.name}
          </div>
          <div className="pending-application-section-title">Vendor Type </div>
          <div className="pending-application-section-desc">
            {VendorDetails.vendorCategory}
          </div>
          <Button variant="primary" className="pending-application-banner">
            Applicant Details{" "}
          </Button>{" "}
          <div className="pending-application-section-title">
            Applicant Name{" "}
          </div>
          <div className="pending-application-section-desc"> {VendorDetails.name}</div>
          <div className="pending-application-section-title">
            Applicant Address{" "}
          </div>
          <div className="pending-application-section-desc">
            {VendorDetails.address}
          </div>
          <div className="pending-application-section-title">
            Educational qualification{" "}
          </div>
          <div className="pending-application-section-desc">
            {" "}
            BE in Computers, IIT Bombay
          </div>
          <div className="pending-application-section-title">Documents </div>
          <div className="pending-application-docs">
            <a
              href={VendorDetails.aadharcardImageUrl}
              target="_blank"
              rel="noreferrer"
            >
              View aadhar card
            </a>
            <a
              href={VendorDetails.pancardImageUrl}
              target="_blank"
              rel="noreferrer"
            >
              View PAN Card
            </a>
          </div>
          <div className="pending-application-btn">
            <Button variant="primary">Approve</Button>{" "}
            <Button variant="primary">Reject</Button>{" "}
          </div>
        </div>
        <div className="pending-application-container-item">
          <div className="pending-application-section-title">
            Vendor Location{" "}
          </div>
          <div className="pending-application-section-desc">
            {VendorDetails.address}
          </div>
          <LoadScript
                  googleMapsApiKey="AIzaSyClwDKfzGV_7ICoib-lk2rH0iw5IlKW5Lw"
                  libraries={["places"]}
                >
                  <GoogleMap
                    id="marker-example"
                    mapContainerStyle={containerStyle}
                    center={center}
                    zoom={16}>
                    <MarkerF
                      // onLoad={onLoad}
                      position={position}
                    />
                    <MarkerF />
                  </GoogleMap>
                </LoadScript>
        </div>
      </div>
    </div>
  );
}

export default VendorApplicationDetails;

export async function getServerSideProps(context) {
  const { params } = context;
  const { application_id } = params;
  const res = await axios.get(
    "http://localhost:4000/api/getvendorsfromID/" + application_id
  );
  // console.log(res);
  const data = await JSON.parse(JSON.stringify(res.data));
  return {
    props: {
      VendorDetails: data,
    },
  };
}
