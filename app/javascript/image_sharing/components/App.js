import React from 'react';
import { Alert, Button, Container, Form, FormGroup, Label, Input } from 'reactstrap';
import fetch from 'node-fetch';
import Header from './Header';
import Footer from './Footer';
import { getCsrfToken } from '../utils/helper';

export default class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      name: '',
      comments: '',
      error: '',
      submitted: false,
    };
  }

  handleSubmit = (e) => {
    e.preventDefault();

    const { name, comments } = this.state;
    let error;

    const requestOptions = {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', 'X-CSRF-Token': getCsrfToken() },
      body: JSON.stringify({ name, comments })
    };
    fetch('/api/feedbacks', requestOptions)
      .then(response => response.json())
      .then((data) => {
        error = data.status === 'success' ? '' : data.error || 'Unknown error occured :(';
      }).catch((err) => { error = err.message; })
      .then(() => this.setState({
        error,
        submitted: true,
        name: error ? name : '',
        comments: error ? comments : ''
      }));
  }

  render() {
    return (
      <Container>
        <Header title="Tell us what you think" />
        {this.state.submitted &&
          <Alert color={
            this.state.error ? 'danger' : 'success'
          }
          >
            {this.state.error || 'Successfully submitted!'}
          </Alert>
        }
        <Form onSubmit={this.handleSubmit}>
          <FormGroup>
            <Label for="nameForm">Your Name:</Label>
            <Input
              type="text"
              id="nameForm"
              value={this.state.name}
              onChange={e => this.setState({ name: e.target.value })}
            />
          </FormGroup>
          <FormGroup>
            <Label for="commentsForm">Comments: </Label>
            <Input
              type="textarea"
              id="commentsForm"
              value={this.state.comments}
              onChange={e => this.setState({ comments: e.target.value })}
            />
          </FormGroup>
          <Button color="primary">Submit</Button>
        </Form>
        <Footer text="Copyright: Appfolio Inc. Onboarding" />
      </Container>
    );
  }
}
