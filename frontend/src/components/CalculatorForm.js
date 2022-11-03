import React, { Component } from "react";
import { Form, Button } from "react-bootstrap";

class CalculatorForm extends Component {
  
  onFormChange = (event) => {
    const target = event.target;
    const value = target.value;
    const name = target.name;

    this.setState({
      [name]: value
    });
  };

  onFormSubmit = (event) => {
    event.preventDefault();
    this.props.handleSubmit(this.state);
  }
  render() {
    return (
      <Form onSubmit={this.onFormSubmit} id="calculatorForm">
        <Form.Group className="mb-3" controlId="formLength">
          <Form.Label>Product Length</Form.Label>
          <Form.Control name="length" type="number" placeholder="Enter Length" onChange={this.onFormChange}/>
        </Form.Group>
        <Form.Group className="mb-3" controlId="formWidth">
          <Form.Label>Product Width</Form.Label>
          <Form.Control name="width" type="number" placeholder="Enter Width" onChange={this.onFormChange} />
        </Form.Group>
        <Form.Group className="mb-3" controlId="formHeight">
          <Form.Label>Product Height</Form.Label>
          <Form.Control name="height" type="number" placeholder="Enter Height" onChange={this.onFormChange}/>
        </Form.Group>
        <Form.Group className="mb-3" controlId="formWeight">
          <Form.Label>Product Weight</Form.Label>
          <Form.Control name="weight" type="number" placeholder="Enter Weight" onChange={this.onFormChange}/>
        </Form.Group>
        <Button variant="primary float-end" type="submit">
          Calculate
        </Button>
      </Form>
    );
  }
}

export default CalculatorForm;
