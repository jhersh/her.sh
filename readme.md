# her dot sh

[![CircleCI](https://dl.circleci.com/status-badge/img/gh/jhersh/her.sh/tree/master.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/gh/jhersh/her.sh/tree/master)

Source for [her.sh](https://her.sh).

### Architecture

her.sh is a static site...

- Generated by [Jekyll](http://jekyllrb.com/)
- Hosted on [Amazon S3](https://aws.amazon.com/s3/) and [Amazon Cloudfront](https://aws.amazon.com/cloudfront/) for great uptime and incredibly low cost
- With a free SSL certificate from [AWS Certificate Manager](https://aws.amazon.com/certificate-manager/) for HTTPS

### Running Locally

It's super easy to build the site and test it locally:

```
rake setup
rake serve
```

### Publishing

The site is deployed to S3 by CircleCI, using [s3cmd](http://s3tools.org/s3cmd), a handy command-line tool for S3.

### Thanks!

her.sh is a [@jhersh](https://github.com/jhersh) production -- ([electronic mail](mailto:jon@her.sh))
